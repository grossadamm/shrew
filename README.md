# Shrew


Simple analytics engine for rails

### Installation

Run the generator to install the migration and routes.

```
rails g analytics:install
rake db:migrate
```

Add page tracking to your application controller (or any other controller)

```
class ApplicationController < ActionController::Base
  include Shrew::TracksPageViews
end
```

*For tracking javascript run time*

Include shrew.js in your application.js

```
//= require shrew
```

Include the partial at the end of your layout to automatically track javascript run time

```
...
<%= render "shrew/automatically_track_page_views" %>
</body>
</html>
```

### Configuration

See the initializer for configuration