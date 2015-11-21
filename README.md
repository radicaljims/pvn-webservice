1. Download stack (and maybe Haskell for OSX as well):

  * https://github.com/commercialhaskell/stack#how-to-install
  * https://ghcformacosx.github.io/

2. Checkout the repository

  ```bash
  git clone https://github.com/radicaljims/pvn-webservice.git
  ```

3. Setup stack and build the project

  ```bash
  stack setup && stack build
  ```

4. Run the webservice

  ```bash
  stack exec pvn-webservice
  ```

5. Poke it with curl or a browser

  ```bash
  curl http://localhost:8081/users
  ```

```javascript
[{"email":"hero@unikernel.com","registration_date":"2015-11-20","name":"Jim Sandridge"},{"email":"pooppoop@unicorn.com","registration_date":"2015-11-20","name":"Tim Ferrell"}]
```


