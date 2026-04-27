name: Deploy PHP App to Shared Hosting

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          fetch-depth: 2

      - name: Determine changed files
        id: changed-files
        run: |
          git diff --name-only HEAD~1 > changed_files.txt

      - name: Display changed files
        run: |
          cat changed_files.txt

      - name: Install MySQL Client
        run: sudo apt-get install -y mysql-client

      - name: Install lftp
        run: sudo apt-get update && sudo apt-get install -y lftp

      - name: Deploy entire PHP app to Shared Hosting
        run: |
          lftp -e "set ftp:ssl-allow no; open -u ${{ secrets.CPANEL_USERNAME }},${{ secrets.CPANEL_PASSWORD }} ${{ secrets.CPANEL_HOST }}; mirror -R . /public_html; exit"