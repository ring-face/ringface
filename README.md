# Run it all
![ringface](https://user-images.githubusercontent.com/7328002/112440498-adecb680-8d4a-11eb-9c36-722062f4c754.gif)


## Attach your own doorbell
In order to link your own ring doorbell, you will need to provide your own `oauth-autorization.json` file. 

This is easiest done by running a special container for downloading the authorization info. The python script in the contaier will ask for your ring credentials, possibly second factor, if you enabled that, and create the required file `oauth-autorization.json` in the current dir.
```bash
docker run -a stdin -a stdout -it -v $(pwd):/app/output ringface/createauth
```
After the container has finished, you will find the `oauth-autorization.json` in the current dir. It is time to run some recognition.

## Start the application
To run the whole recognition setup, you can simply run
`docker-compose up`. 

This will start the **db**, the **classifier** the **connector**  the **bff** and the **nginx** server with the angular bundle of the GUI. You can then visit the angular GUI at http://localhost:4300

## Use the application
You should start by downloading the latest videos from your ring device. On http://localhost:4300 open the Today accordion, and click the **Download events button**. In the ./data/videos dir, you will find the newly downloaded videos.

Once the videos are dowloaded, you can click the **Recognise** button on the event. This will process the video file, and find the faces. 

Once faces have been found, you can click the **Tag person** button. Further recognition runs will recognise this person automatically.

## Push notifications
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
