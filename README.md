# ZypeSDK [![Build Status](https://travis-ci.org/lucasmedeirosleite/zype-sdk.svg)](https://travis-ci.org/lucasmedeirosleite/zype-sdk) [![Code Climate](https://codeclimate.com/github/lucasmedeirosleite/zype-sdk/badges/gpa.svg)](https://codeclimate.com/github/lucasmedeirosleite/zype-sdk) [![Coverage Status](https://coveralls.io/repos/github/lucasmedeirosleite/zype-sdk/badge.svg?branch=master)](https://coveralls.io/github/lucasmedeirosleite/zype-sdk?branch=master)

## Installing

```ruby
gem 'zype_sdk', github: 'lucasmedeirosleite/zype-sdk', branch: master
```

## Configuring

In some part of your code, or if you are using rails, put it in an initializer

```ruby
ZypeSDK.configure do |config|
  config.app_key = 'your-zype-app-key',
  config.client_id = 'your-zype-client-id'
  config.client_secret = 'your-zype-client-secret'
end
```

## Using

For now the ZypeSDK contains only three API Calls:

* Login
* Retrieve videos
* Retrieve a video

## Responses

All three API calls have their return response together with a status, the status are represented
in the table below.

### Endpoints

SDK Status | HTTP Status
--- | --- 
:ok | 200
:unauthorized | 401
:not_found | 404
:internal_error | 500

### Login

You can use the login action like this:

```ruby
result = ZypeSDK.login(username: 'you@email.com', password: 'your-password')
```

If for some reason you passed an invalid client id or client secret during the sdk setup,
the result will be something like this:

```console
=> #<struct ZypeSDK::UseCases::Login::Result
 status=:unauthorized,
 content=
  {"error"=>"invalid_client",
   "error_description"=>"Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method."}>   
```

When passing invalid credentials, the result will be something like this:

```console
=> #<struct ZypeSDK::UseCases::Login::Result
 status=:unauthorized,
 content=
  {"error"=>"invalid_grant",
   "error_description"=>"The provided authorization grant is invalid, expired, revoked, does not match the redirection URI used in the authorization request, or was issued to another client."}>
```

When passing valid credentials, the result will be something like this:

```console
=> #<struct ZypeSDK::UseCases::Login::Result
 status=:ok,
 content=
  {"access_token"=>"a-valid-access-token",
   "token_type"=>"bearer",
   "expires_in"=>604800,
   "refresh_token"=>"a-valid-refresh-token",
   "scope"=>"consumer",
   "created_at"=>1507415028}>
```

### Video

You can use the video action like this:

```ruby
result = ZypeSDK.video('a-video-id')
```

If for some reason you passed an invalid app key during the sdk setup,
the result will be something like this:

```console
=> #<struct ZypeSDK::UseCases::Video::Result
 status=:unauthorized,
 content=
  {"message"=>""message": "Invalid or missing authentication."}>   
```

When passing a non existent video id:

```console
=> #<struct ZypeSDK::UseCases::Video::Result
 status=:not_found,
 content=
  {"message": "Video not found"}>
```

When passing an existent video id:

```console
=> #<struct ZypeSDK::UseCases::Video::Result
 status=:ok,
 content=
  { "response" => {
      "_id" => "56a7b83169702d2f8336d9b7",
      "active" => true,
      "subscription_required" => false,
      "title" => "Santa Baby - SNL",
      "thumbnails" => [
        {
            "aspect_ratio" => 1.33,
            "height" => 90,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/default.jpg",
            "width"=> 120
        },
        {
            "aspect_ratio" => 1.78,
            "height" => 180,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/mqdefault.jpg",
            "width" => 320
        },
        {
            "aspect_ratio" => 1.33,
            "height" => 360,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/hqdefault.jpg",
            "width" => 480
        },
        {
            "aspect_ratio" => 1.33,
            "height" => 480,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/sddefault.jpg",
            "width" => 640
        },
        {
            "aspect_ratio" => 1.78,
            "height" => 720,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/maxresdefault.jpg",
            "width" => 1280
        }
      ]
      ...
    } 
  }>
```

### Videos

You can use the video action like this:

```ruby
result = ZypeSDK.videos(per_page: 15, page: 2) # params are optional
```

If for some reason you passed an invalid app key during the sdk setup,
the result will be something like this:

```console
=> #<struct ZypeSDK::UseCases::Videos::Result
 status=:unauthorized,
 content=
  {"message"=>""message": "Invalid or missing authentication."}>   
```

When the method call succeeds:

```console
=> #<struct ZypeSDK::UseCases::Videos::Result
 status=:ok,
 content=
  { "response" => [{
      "_id" => "56a7b83169702d2f8336d9b7",
      "active" => true,
      "subscription_required" => false,
      "title" => "Santa Baby - SNL",
      "thumbnails" => [
        {
            "aspect_ratio" => 1.33,
            "height" => 90,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/default.jpg",
            "width"=> 120
        },
        {
            "aspect_ratio" => 1.78,
            "height" => 180,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/mqdefault.jpg",
            "width" => 320
        },
        {
            "aspect_ratio" => 1.33,
            "height" => 360,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/hqdefault.jpg",
            "width" => 480
        },
        {
            "aspect_ratio" => 1.33,
            "height" => 480,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/sddefault.jpg",
            "width" => 640
        },
        {
            "aspect_ratio" => 1.78,
            "height" => 720,
            "name" => null,
            "url" => "https://i.ytimg.com/vi/CkrpvCs-kfE/maxresdefault.jpg",
            "width" => 1280
        }
      ]
      ...
    }]
    "pagination": {
      ...
    }
  }>
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
