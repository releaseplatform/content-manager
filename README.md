# ContentManager

A simple CMS for storing key -> value associated content in postgresql.

## Key Concepts

As of version 0.0.2 there are 3 key concepts in CM (ContentManager):

* Views
* Templates
* Content

### Views

Views are a table in the database wich identify a Constant in the code base. Through this constant a developer can access the key -> associated content. Being linked to a Constant allows attributes to be declared adhoc (as the requirements for content might change considerably over time).

### Templates

Templates are simply a string value that represents the name of the file which could be used to render the view.

### Content

TODO:
