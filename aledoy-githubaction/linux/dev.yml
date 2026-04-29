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

      #- name: Copy all PHP app to Live Server
      #  run: |
      #    scp -i ~/.ssh/deploy_key -o StrictHostKeyChecking=no -r ./* ${{ secrets.USER_NAME }}@${{ secrets.SSH_HOST }}:/var/www/html

      - name: Determine changed files
        id: changed-files
        run: |
          git diff --name-only HEAD~1 > changed_files.txt

      - name: Display changed files
        run: |
          cat changed_files.txt

      - name: Create necessary directories on server
        run: |
          while read file; do
            if [[ -f "$file" ]]; then
              dir=$(dirname "$file")
              ssh -o StrictHostKeyChecking=no ${{ secrets.USER_NAME }}@${{ secrets.SSH_HOST }} "if [ ! -d /var/www/html/$dir ]; then mkdir -p /var/www/html/$dir; fi"
            fi
          done < changed_files.txt

      - name: Copy changed files to server
        run: |
          while read file; do
            if [[ -f "$file" ]]; then
              scp -o StrictHostKeyChecking=no "$file" ${{ secrets.USER_NAME }}@${{ secrets.SSH_HOST }}:/var/www/html/"$file"
            fi
          done < changed_files.txt
