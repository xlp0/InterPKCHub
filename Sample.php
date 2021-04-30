
<?php


## The protocol and server name to use in fully-qualified URLs
$wgServer = "http://localhost:9352";

# The following two lines contains information on Github's OAuth service. You will have to apply for your own information to get things to work.
$wgOAuth2Client['client']['id'] = "83698ede718fea93a79e";
$wgOAuth2Client['client']['secret'] = "290648a66406e1bb3c5655a96c34b62fac5e4e9a";

$wgOAuth2Client['configuration']['authorize_endpoint']     = 'https://github.com/login/oauth/authorize'; // Authorization URL
$wgOAuth2Client['configuration']['access_token_endpoint']  = 'https://github.com/login/oauth/access_token'; // Token URL
$wgOAuth2Client['configuration']['api_endpoint']           = 'https://api.github.com/user'; // URL to fetch user JSON
$wgOAuth2Client['configuration']['redirect_uri'] = "http://localhost:9352/index.php/Special:OAuth2Client/callback";
$wgOAuth2Client['configuration']['username'] = 'login'; // JSON path to username
$wgOAuth2Client['configuration']['email'] = 'email'; // JSON path to email
$wgOAuth2Client['configuration']['scopes'] = 'openid email profile'; //Permissions
$wgOAuth2Client['configuration']['service_name'] = 'Oauth Registry'; // the name of your service
$wgOAuth2Client['configuration']['service_login_link_text'] = 'Login through Github'; // the text of the login link

