# docker-7DaysToDie server

## Based on:
    Docker image for 7 Days to Die
    http://jamessmoore.github.io/docker-7DaysToDie/
    
## How to Build and Run:
  * (OPTIONAL) Modify _**serverconfig_template.xml**_ to suite your needs.  These values might be change on run time by passing them as environment variables to the docke container
  * Build image using a command like: 

```bash
docker build  -t krusmir/docker7daystodie-server .
```
  * Once built, start server with:

```bash
  docker run --name=7daystodie-server \
 -p 26900:26900/udp \
 -p 26901:26901/udp \
 -p 8080:8080/tcp \
 -p 8081:8081/tcp \
 --env STEAM_USERNAME=YOUR_STEAM_USERNAME \
 --env STEAM_PASSWORD=YOUR_STEAM_PASSWORD \
 krusmir/docker7daystodie-server
 ```
You can also start the server with custom configuration values when starting the container.  For example, if you want your server to not be public, with AirDropFrequency every 24 hours, disable EAC and change the name of the game to something more original, you can start the server has follows:

```bash
  docker run --name=7daystodie-server \
 -p 26900:26900/udp \
 -p 26901:26901/udp \
 -p 8080:8080/tcp \
 -p 8081:8081/tcp \
 --env STEAM_USERNAME=YOUR_STEAM_USERNAME \
 --env STEAM_PASSWORD=YOUR_STEAM_PASSWORD \
 --env GameName=MyAwesome7d7d \
 --env ServerIsPublic=false \ 
 --env AirDropFrequency=24 \
 --env EACEnabled=false \
 krusmir/docker7daystodie-server
 ```

Remember to change _**YOUR_STEAM_USERNAME**_ and _**YOUR_STEAM_PASSWORD**_ with your steam username and password.  
 
To avoid **Steam Guard Code** problems, disable it on your steam account.  Since this might pose a security problem for your steam account, it's recommended to create a new steam account dedicated for the server and protect it with a strong password.  Or not, depends how paranoid you are. 

Another alternative to avoid **Steam Guard Code** problems is to disable it when you deploy the server, and enable it afterwards.
 
