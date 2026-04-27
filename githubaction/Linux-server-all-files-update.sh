name: Update Files and DB Script on Linux Server.

on:
  push:
    branches:
      - main # or the branch you want to trigger this action

jobs:
  run-update-script:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          fetch-depth: 2 # Fetch enough history to compare with the previous commit

      - name: Set up SSH agent
        uses: webfactory/ssh-agent@v0.5.3
        with:
          ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}

      - name: Install SSH client
        run: sudo apt-get update && sudo apt-get install -y openssh-client

      - name: Create known_hosts file
        run: mkdir -p ~/.ssh && touch ~/.ssh/known_hosts

      - name: Add Server host key to known_hosts
        run: ssh-keyscan -H ${{ secrets.SSH_HOST }} >> ~/.ssh/known_hosts

      - name: Copy all PHP app to Live Server
        run: |
          scp -i ~/.ssh/deploy_key -o StrictHostKeyChecking=no -r ./* ${{ secrets.USER_NAME }}@${{ secrets.SSH_HOST }}:/var/www/html
