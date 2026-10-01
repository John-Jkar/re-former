# re-former

This is part of the Forms Project in The Odin Project's Ruby on Rails Curriculum. Find it at https://www.theodinproject.com

Lessons covered here:

* Bare metal HTML forms (method/action, labels, inputs, `accept-charset`)
* CSRF protection and `form_authenticity_token`
* Turbo intercepting form submissions (`data-turbo="false"`, `Processing by UsersController#create as TURBO_STREAM`)
* Nesting params into a hash with `name="user[email]"`
* Strong parameters with a private `user_params` method
* `form_with` for both new and persisted records
* Rendering validation errors with `@user.errors.full_messages`

## Setup

```bash
bundle install
bin/rails db:migrate
bin/rails server
```

Then visit http://localhost:3000/users/new

## Routes

```bash
bin/rails routes
```