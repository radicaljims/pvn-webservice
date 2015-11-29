1. Install Postgres

  ```bash
  brew install postgres
  ```

  (Don't do this part in tmux)
  ```bash
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  ```

2. Setup Postgres

  ```bash
  ./setup_postgres.sh
  ```

3. Download stack (and maybe Haskell for OSX as well):

  ```bash
  brew install haskell-stack
  ```

  * https://github.com/commercialhaskell/stack#how-to-install

4. Checkout the repository

  ```bash
  git clone https://github.com/radicaljims/pvn-webservice.git
  ```

5. Setup stack and build the project

  ```bash
  stack setup && stack build
  ```

6. Run the webservice

  ```bash
  stack exec pvn-webservice
  ```

7. Poke it with curl or a browser

  ```bash
  curl http://localhost:8081/users
  ```

```javascript
[{"email":"hero@unikernel.com","registration_date":"2015-11-20","name":"Jim Sandridge"},{"email":"pooppoop@unicorn.com","registration_date":"2015-11-20","name":"Tim Ferrell"}]
```


