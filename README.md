Download stack (and maybe Haskell for OSX as well): https://github.com/commercialhaskell/stack#how-to-install

Clone repo

'''bash
stack setup

stack build

stack exec pvn-webservice

curl http://localhost:8081/users
'''

'''javascript
[{"email":"hero@unikernel.com","registration_date":"2015-11-20","name":"Jim Sandridge"},{"email":"pooppoop@unicorn.com","registration_date":"2015-11-20","name":"Tim Ferrell"}]
'''


