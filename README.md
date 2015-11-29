1. Install Postgres

  ```bash
  brew install postgres
  ```

  (Don't do this part in tmux)
  ```bash
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  ```

2. Download stack (and maybe Haskell for OSX as well):

  ```bash
  brew install haskell-stack
  ```

  * https://github.com/commercialhaskell/stack#how-to-install

3. Checkout the repository

  ```bash
  git clone https://github.com/radicaljims/pvn-webservice.git
  cd pvn-webservice
  ```

4. Setup Postgres

  ```bash
  ./setup_postgres.sh
  ```

5. Setup stack and build the project

  ```bash
  stack setup && stack build
  ```

6. Run the webservice

  ```bash
  stack exec pvn-webservice
  ```

7. Add a dumb user

  ```bash
  ./add_user.sh
  ```

8. List the dumb users

  ```bash
  ./list_users.sh
  ```

```javascript
[{"email":"foo@foo.com","registrationDate":"2015-11-11","name":"foo"}]
```


