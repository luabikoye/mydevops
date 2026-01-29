#Loop through multiple regions inside the same Lambda

import boto3

def lambda_handler(event, context):
    ec2_regions = [region['RegionName'] for region in boto3.client('ec2').describe_regions()['Regions']]
    
    results = {}
    
    for region in ec2_regions:
        ec2 = boto3.client('ec2', region_name=region)
        
        filters = [{
            'Name': 'tag:Environment',
            'Values': ['Dev']
        }]
        
        instances = ec2.describe_instances(Filters=filters)
        ids = [i['InstanceId'] for r in instances['Reservations'] for i in r['Instances']]
        
        if ids:
            ec2.stop_instances(InstanceIds=ids)
            print(f"[{region}] Stopped instances: {ids}")
            results[region] = ids
        else:
            print(f"[{region}] No instances to stop")
            results[region] = []
    
    return results