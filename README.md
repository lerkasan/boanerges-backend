In order to run the project, you need to have the following dependencies installed:
- Docker
- Docker Compose

1. Set up environment variables:
   - MYSQL_ROOT_PASSWORD
   - DB_NAME
   - DB_USERNAME
   - DB_PASSWORD
   
_Example:_
`export MYSQL_ROOT_PASSWORD=myextremelysecurepassword`


2. Run the following command to build the backend image:

`docker build -t lerkasan/boanerges-backend:latest .`


3. Clone the following repository to get the frontend source code:
[lerkasan/boanerges-frontend](https://github.com/lerkasan/boanerges-frontend)


4. Change directory to the frontend project and build the frontend image according to the instructions in the frontend repository:

`cd boanerges-frontend`

`docker build -t lerkasan/boanerges-frontend:latest .`

5. Run the project:

`docker compose up`

6. Open http://localhost URL in your browser.


7. To stop the project, press `Ctrl + C` or run the following command:

`docker compose down`