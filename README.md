# Run it all
![ringface](https://user-images.githubusercontent.com/7328002/112440498-adecb680-8d4a-11eb-9c36-722062f4c754.gif)


## Attach your own doorbell
In order to link your own ring doorbell, you will need to provide your own `oauth-authorization.json` file. This file contains the Bearer and Refresh tokens from the OAUTH, similar to this

```json
{
  "access_token": "eyJhbGciOiJIUzUxMiIsImprdSI6Ii9vYXV0aC9pbnRlcm5hbC9qd2tzIiwia2lkIjoiYzEyODEwMGIiLCJ0eXAiOiJKV1QifQ.xxx.yyy",
  "expires_in": 3600,
  "refresh_token": "eyJhbGciOiJIUzUxMiIsImprdSI6Ii9vYXV0aC9pbnRlcm5hbC9qd2tzIiwia2lkIjoiYzEyODEwMGIiLCJ0eXAiOiJKV1QifQ..xxx.yyy",
  "scope": ["client"],
  "token_type": "Bearer",
  "expires_at": 1665154906.0984125
}
```

There are multiple ways to extract this from Ring.com. The simplest is done by running a docker container for downloading the authorization info. The python script in the contaier will ask for your ring credentials, and second factor, if you enabled that, and create the required file `oauth-autorization.json` in the current dir.
```bash
docker run -a stdin -a stdout -it -v $(pwd):/app/output ringface/createauth
#WARNING:root:will create new oauth json file at /app/output/oauth-autorization.json
#Please enter your ring Username: someonee@yahoo.com
#Please enter your ring Password: 
#Please enter your 2FA code that was sent to you: 832009
#WARNING:root:new token file created
```
After the container has finished, you will find the `oauth-autorization.json` in the current dir. It is time to run some recognition.

## Start the application
To run the whole recognition setup, you need to create a `.env` file and simply run the app in a docker container.
```bash
cp .env-sample .env
docker-compose up`.
```


This will start the **db**, the **classifier** the **connector**  the **bff** and the nginx server with the **angular frontend** of the GUI. You can then visit the application at http://localhost:4300

## Use the application
You should start by downloading the latest videos from your ring device. On http://localhost:4300 open the Today accordion, and click the **Download events button**. In the ./data/videos dir, you will find the newly downloaded videos. To read more on how the ring connector downloads the videos, [go here](https://github.com/ring-face/ringface-connector).

Once the videos are dowloaded, you can click the **Recognise** button on the event. This will process the video file, and detect the faces. The recognition uses a pre calibrated AI from the excellent DLIB toolkit. [See more infos here.](https://github.com/ring-face/ringface-classifier) 

Once faces have been found, you can click the **Tag person** button. Further recognition runs will now be able to name the person at your doorstep.

## Apple watch notifications
Push notifications are supported through the IFTTT integration. It is recommended to create two IFTTT applets, one for the smartphone push notification and one for triggering the processing of the new ding event.

Prerequisites are an account on ifttt.com, and connecting your ring doorbell with ifttt.com. Additional prerequisite is to host your ringface installation on a publicly available URL, eg https://ring.example.com

### Push notification applet
This applet will ensure, that when the ring button is clicked, you receive a push notification, that will forward you to your ring installation. 
* If New Ring detected at Ding device, 
* then Send a rich notification from the IFTTT app. Add https://ring.example.com as link url field.

### Ringface tagging trigger
Your installation provides a https://ring.example.com/api/ifttt/event endpoint, that can be POSTed from IFTTT to trigger the download and face recognition when the ring doorbell button is pressed.
The applet is
* If New Ring detected at Ding device, 
* Then make a web request equivalent of 
```bash
curl --location --request POST 'https://ring.example.com/api/ifttt/event' \
--header 'Content-Type: application/json' \
--data-raw {
"createdAt": "{{CreatedAt}}",
"doorbellName": "{{DoorbellName}}"
}
```
