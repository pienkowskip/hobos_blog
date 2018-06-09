# Hobos Blog

## Setup and deploy

1. Clone repository.

2. Install libs:
    ```
      sudo apt-get install libpq-dev 
    ```

3. Install gems:
    ```
      bundle install --without development test
    ```

3. Create database. Add fulltext search dictionary `bin/scripts/pg_hunspell_install.sh` &ndash; more info at: <https://github.com/lemonskyjwt/plpstgrssearch>.

4. Configure `config/database.yml`, `config/secrets.yml` and `config/mailer.yml`.

5. Migrate database.

6. Precompile and copy assets:
    ```
      RAILS_ENV=production rake assets:precompile
      cp -r vendor/assets/images/* public/assets/
      cp -r vendor/assets/fonts/* public/assets/
    ```
    
7. Setup thin or other favorite application server to
serve app.

8. Setup redirection (8080 to 80) or proxy server (ngix/apache).