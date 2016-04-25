# ContentManager

A simple CMS for storing key -> value associated content in postgresql.

## The Concept: Views

The core concept underlying content_manager is views. A View is simply a relationship between a URL, a Template, a Layout, a Style and some Content.

content_manager manages the views but only that parts that you need at any given point in time. In this way, as you're requirements for dynamically displaying and confguring what your users see changes, the way your can use content_manager changes as well. For each of the responcibilities, the way you use content_manager will be outlined below.

### URLs
content_manager never takes control of mapping views to urls. This is because the framework it was built to work with, Ruby on Rails, manages this mapping for you. If you require the urls at which views are displayed to be configurable you should look at another CMS

 * list of CMSs

### Templates
Templates are HTML documents. The realationship between a URL and a Temaplate (the View) changes less often than other things so in it's simplest form, content_manager assumes no responcibility for your templates.

Should you need to have your templates configurable (for A/B Testing or User configurable views) then there are a number of ways content_manager can help.

1. **Not at all**

    content_mamager does not need to take care of your templates if you don't want it to! Just use the existing templating system that your framework / language uses.

2. **Hardcoded Templates:**

    At it's most simple, configurable templates can be one of a set of hardcoded templates. The way you achieve this with content_manager is to make a directory where your view used to be:
    
    `index.html.erb` -> `index/`
    
    And then to put the different templates you wish to be able to choose from into the directory. e.g.
    
        index/
            facebook_landing_page.html.erb
            twitter_landing_page.html.erb
            big_red_button_landing_page.html.erb
            small_green_button_landing_page.html.erb

    These will then be available to change at the content_manager url for the index view. This is usually: 
    
     `<content_manager_root>/views/:view_id`
    
3. **Dynamic Templates**
    
    These are templates that can be edited without re-deploying the codebase. content_manager does not currently support them but should be requested / get enough support then they will be implemented.
    

### Layouts

Layouts are just our term for a restrcited set of css declarations. These shoud only be declarations that change the pixel position of elements in the browser. A full list of statements that fit into the layout category are provided [here]().

There are again, a number of ways that layouts can be configured:

1. **Not at all**
    
    At the most simple level, content_manager doesn't need to be responsible for your layout. You can manage this in Rails (or your framework of choice's) with the existing asset pipeline and directory structure.

2. **Hardcoded**

    This is for situations where you need a set of layouts that a user can select from but not necessarily directly manipulate. In this instance content_manager will look for a folder like so:
    
    `app/assets/stylesheets/<view_name>/<layout_name>.css`
    
    A list of these layouts will be provided at the content_manger url for the view:
    
    `<content_manager_root>/views/:view_id`
    
    You can select the layout you want from the available `.css` files and it will be associated with the view, accessible from:
    
    `view.active_layout`
    
3. **Dynamic**

    content_manager does not currently support dynamic layouts but should support be requested then it will be proritised as a feature depending on the value it will provide.
    
### Styles

Styles are another restricted set of css declarations. These are the ones that are about the colors and fonts (may not be forever, typography effects positioning). Similarly to layouts there are 3 ways that these can be configured:

1. **Not at all**

    At the most simple level, content_manager doesn't need to be responsible for your styles. You can manage this in Rails (or your framework of choice's) with the existing asset pipeline and directory structure.
 
    
2. **Hardcoded**

    In this instance it will provide a list of files at:
    
    `app/assets/stylesheets/<style>.css`
    
    once you select one it will associate that filename with the view and you can then access it from the view object like so:
    
    `view.active_style`

3. **Dynamic**

    content_manager does not yet support dynamic views but has every intention of doing so. How this will be provided is yet to be decided but likely to be something like the mailchimp email editor interface.

### Content

Finally content. This is provied through the function:

`cm :content_key`
    
This is available in views of controllers that include:

`ContentManger::Controller`

You define a simple 'schema' for a views content by putting a subclass of `ContentManager::ContentBase` in `app/content/`. It will look something like so:

```ruby
class ControllerActionContent < ContentManager::ContentBase
    content_alias 'Controller Action'
    content_key :title, default: 'Action'
    content_key :call_to_action, default: 'Do this thing please!'
end
```

All content for that view will use this 'schema' and only keys written in the 'schema' will be available via the `cm :content_key` function.
    