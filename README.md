# CoreUI CodeIgniter 3 Admin Template
### A complete user registration system in CodeIgniter

Default Email: admin@example.com
Default Password: admin123

A CodeIgniter starter admin interface using [CoreUI Bootstrap HTML template](https://github.com/mrholek/CoreUI-Free-Bootstrap-Admin-Template). You can use this template as a starting point for your CodeIgniter application. I developed this for my personal projects and now I'm uploading it here with a hope that this will save a good amount of time for CodeIgniter developers.

## Main Features:
* Full user CRUD system included for admins
* Optional user signup feature on registration page (if enabled in settings)
* Password reset via email
* Optional 2-step authentication via Twilio API
* A complete user model that provides all main and meta info of users

## How to use
* Upload the zip file's content to your application's root directory
* Create a database and set the credentials in ```application/config/database.php```
* Import the SQL file to your database
* Edit ```config.php``` and set your app's URL. That's all!

Once installed, you can start creating your own models, controllers and views. Happy coding!

## User model
User model is already auto-loaded and you can use it to retrieve/use information about the logged in user and all other users:
### Get signed-in user info
```php
$user = $this->user_model->userinfo();
```
Now the ```$user``` object will contain all info about the signed in user.

### Get any other user's info
```php
$user = $this->user_model->userinfo(1);
```
```$user``` object will contain information for user with ID ```1```. If user doesn't exist in the database, then ```$user``` will return ```false```.

### Add a user
```php
$data = array(
  'first_name' => 'John',
  'last_name' => 'Doe',
  'email' => 'email@example.com',
  'password' => 'asdf',
  'role' => $this->user_model->get_roleid_by_name('User') // or Admin or any other roles you add to roles table
);
$add = $this->user_model->add_user($data); // $add will contain a JSON object containing status and user id if the insert was successful
```
### Update a User
```php
$this->user_model->update_user($user_id, $new_data);
```
### Add Meta
```php
$meta_data = array(
  'address_line_1' => 'Address Line 1 here',
  'user_nick_name' => 'Nick Name'
);
$this->user_model->add_meta($user_id, $meta_data);
```
### Get Meta
Meta info is already returned in ```userinfo()``` method but you can retrieve the meta info separately as well using the the ```get_meta()``` method.
```php
$address_line_1 = $this->user_model->get_meta($user_id, 'address_line_1');
```
### Delete a User
```php
$this->user_model->delete_user($id);
```
## Send password reset email
```
$this->user_model->password_reset_request($user_id);
```
In addition to these, there are several other methods as well like email availability check, new password set method and others. You should have a look over the ```User_model.php``` to get complete info or to extend the functionality.
