# PSU Hackathon Sinatra Application

This is the Sinatra application that we're building during the 2014 PSU Hackathon workshop.

Information about the workshop is here:

http://hackpsu.westarete.com/

The workshop is hosted by [West Arete](http://westarete.com).

## Lessons Learned

Despite having only about 2 weeks to prepare this workshop, we feel that it went pretty well. We made it about 75% of the way through the steps by the 11pm cutoff (we honored the hard stop to let people eat). And in the end, we're pretty sure that every person walked away with *some* sort of working Sinatra web applicaiton running on their laptop.

Here are the things that we learned:

- Sinatra was a very good match because it limited the amount of file switching. Rails would be difficult to coordinate in a large group setting simply because there are so many routes/models/views/controllers to switch between.
- We got a broader range of laptop setups than we anticipated. There were lots of Windows machines and older laptops in various states of servicability. 
- Given the point above, a virtual machine environment would be desirable to eliminate setup issues. But many of the laptops would struggle to run a virtual machine (because they were a bit underpowered). There seemed to be benefit for people to walk away with a working development environment.
- We missed several setup steps on Windows. For example, sometimes the "bundler" gem wouldn't be present.
- We should be much more clear about how the steps and code work together. Make access to steps and the code at each step far easier.
- Perhaps it's possible to do development environment setup before the Workshop. Post the extremely detailed instructions online a week ahead of time and set up a system to interact with people as they're working through it. That would improve the odds of everyone showing up with a working setup. Then we can just focus on building the app, which is closer to the goals of the Hackathon itself.
- The app was just about the right size for 1.5 - 2 hours. If workstation setup had been handled ahead of time, it would have been comfortable.
- People had some great questions about context and alternate scenarios as we went through. Build in the time to discuss these.
- The steps were a huge win for working independently during the workshop, and for insurance in case some people couldn't finish during the allotted time -- it's a hackathon, so they can always keep working on it afterwards if the steps are thorough enough.
- Make sure you build in the time to help each individual through each of these steps. The goal of the workshop is not to get through the complete app -- it's to build people's confidence with the development process. 
- We need about 1 helper for every 10-20 workshop attendees. 


If you were at this workshop and have suggestions for future improvement, please submit a Github issue or email us at <team@westarete.com>. We'd love to have your feedback.
