# Bank Accounting API



## What is this Project?

This is an Open API to transfer money between accounts and get balance. The main goal of this API to make easy money transfer ans balance only by passing accounts and amount involved





## How can I use this API

We have basically to endpoints, one to perform money transfer and another one to get the account balance.



###Money Transfer 

For money transfer, you should call:

`POST /api/v1/accounts/:account_id/transfer` with `destination_account_id` and `amount` params at request body

And you'll receive the message if succeed:

`{ message: "Transfer successfully done" }`

Or if it fails:

`{ error: <error message> }`



### Get Balance

To get account balance, you should call:

`GET /api/v1/accounts/:account_id/balance`

And you receive as response:

`{ balance: <balance> }`



****

# I want to Contribute!



## Our Stack

At this project we are using this stack:

- Rails API
- Sqlite
- RSpec
- Puma



## How to setup the project

1. Clone the project at a folder

   `git clone https://github.com/dfmoreto/bank_accouting_api.git`

   

2. Join the folder

   `cd bank_accounting_api`

   

3. Execute bundler

   `bundle install`

   

4. Create db and run migrations for both dev and env test

   `rails db:create db:migrate`

   `RAILS_ENV=test rails db:create db:migrate`

   

5. Start Rails server

   `rails s`

   

6. Try it! : )

   Use a tool and try to reach the API (highly recommend Curl or Postman - AWESOME TOOLS!)



##How to execute tests

We're using RSpec, so our tests are in folder `spec` and configuration for support tools in `spec/support`

To execute ours tests ir very simple, only goes to terminal and execute:

`rspec`

And all tests will run. (I hope Green :D)