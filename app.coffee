serverURL = "http://test.krashdrive.com"

#document.addEventListener 'deviceready', onDeviceReady, false

#temp hard code
identity = "joe+testkd01@megashares.com"
password = "123456789"
#password = "56789"

data =
	identity: identity
	password: password
	remember: 1
 

#helper iterate an object with alert output
alertObj = (data) ->
	alert i for i of data
	return

#finds cookie by name
findCookie = (cookieName) ->
	if document.cookie 
		cookieJar = document.cookie.split ';'
#		cookieName in cookieJar
	else 'no cookie'

# store cookie as local storage key/val pairs from data object
### -- pointless? local storage is only key/val, iterating and object might create thousands of pairs
localCookie = (keyName = "kd-localcookiekey", dataObj) ->
	property for property of dataObj
		localStorage.setItem cookieName, property
###

# login
kdlogin = ->

	$.ajax
		type: 'POST'
		url: "#{serverURL}/auth/login"
		#url: "#{serverURL}/joe.php"
		data: data
		dataType: 'json'
		xhrFields:
			withCredentials: true

	.done (result, textStatus, jqXHR) ->

		#alert items for items of jqXHR
		#alert items for items of data
		alert jqXHR.getResponseHeader 'Set-Cookie'
		alert jqXHR.getAllResponseHeaders()
		#alert jqXHR.statusText
		#alert jqXHR.responseText

		if result.error
			alert result.error_message
		else
			alert 'Woohoo!' + 'You have successfully authorized KrashDrive Sync.'

	#store auth info locally
	localStorage.setItem 'kd-identity', data.identity
	localStorage.setItem 'kd-identity', data.identity

	#alert localStorage.getItem 'kd-identity'
	#alertObj localStorage.getItem 'kd-identity'

	#alert 'findcookie 1 ' + findCookie 'identity'
	#alert 'findcookie 2 ' + findCookie 'remember_code'
	

$('#loadDataButton').click ->
	kdlogin()

###
                        set_cookie(array(
                            'name'   => 'identity',
                            'value'  => $user->{$this->identity_column},
                            'expire' => $expire
                        ));

                        set_cookie(array(
                            'name'   => 'remember_code',
                            'value'  => $salt,
                            'expire' => $expire
                        ));




  # Get List of images from server
  getFeed = ->
    $scroller.empty()
    $.ajax(
      url: serverURL + "/images"
      dataType: "json"
      type: "GET"
    ).done (data) ->
      l = data.length
      i = 0

      while i < l
        $scroller.append "<img src=\"" + serverURL + "/" + data[i].fileName + "\"/>"
        i++
      return

    return

  
  # Upload image to server
  upload = (imageURI) ->
    ft = new FileTransfer()
    options = new FileUploadOptions()
    options.fileKey = "file"
    options.fileName = "filename.jpg" # We will use the name auto-generated by Node at the server side.
    options.mimeType = "image/jpeg"
    options.chunkedMode = false
    # Whatever you populate options.params with, will be available in req.body at the server-side.
    options.params = description: "Uploaded from my phone"
    ft.upload imageURI, serverURL + "/images", ((e) ->
      getFeed()
      return
    ), ((e) ->
      alert "Upload failed"
      return
    ), options
    return

  
  # Take a picture using the camera or select one from the library
  takePicture = (e) ->
    options =
      quality: 45
      targetWidth: 1000
      targetHeight: 1000
      destinationType: Camera.DestinationType.FILE_URI
      encodingType: Camera.EncodingType.JPEG
      sourceType: Camera.PictureSourceType.CAMERA

    navigator.camera.getPicture ((imageURI) ->
      console.log imageURI
      upload imageURI
      return
    ), ((message) ->
    
    # We typically get here because the use canceled the photo operation. Fail silently.
    ), options
    false

  $(".camera-btn").on "click", takePicture
  getFeed()
  return
###
#)()
