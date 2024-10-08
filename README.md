# bloc_clean_architecture_posts

this is a posts app:

architecture patten: clean architecture.

logic:
  this app uses api links to get, delete , add and edit post.
     first: check internet connectivity
             if connected you can :
                    get posts using pagination then caching those posts.
                    add post.
                    delete post.
                    edit post.
             if not connected:
                    you can get posts from cache.


  we include all of these processec in error and exception handling system to prevent out app from caching and improve app performance.

  used design patterns: singleton pattern and factory pattern.
  used packages: 
       cupertino_icons: ^1.0.6
       flutter_bloc:
       dartz:
       get_it:
       equatable:
       internet_connection_checker:
       dio:
       shared_preferences:
       bloc_concurrency:
                    
 
