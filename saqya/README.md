# ALZAYANI WEB CMS

## Requirements

Following requirements are necessary to setup this repository on any environment.
```
PHP  >= 8.2

Composer = 2

Node = 18.18.2,

NPM = v9.8.1
```

## Repo Setup

After cloning this repository create an empty database and run the following command

` cp .env.example .env `

Now add your `Mysql` and other configurations in .env

Now follow the following steps in the same order as they are written

```
composer install

npm install

npm install -g lint-staged

php artisan migrate --seed

```


## Working with this Repo

### API Collection
To access the Postman API collection login using gmail account `tameeny.be@gmail.com`

## GitHub Workflow ( Must to be followed by anyone working on this repo)

~ WIP ~
