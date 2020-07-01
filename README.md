# egograph
Tutorial for making ego graphs in MATLAB


<img src="https://raw.githubusercontent.com/bradmonk/egograph/master/webs/discord_ego_digraph.png" width="800" border="4">


Description
-----------------------------------------------------

    This tutorial describes how to make an 'ego graph' in MATLAB using the 'google vs.' trick. 
    When you type a keyword into the google search bar followed by 'vs' google will attempt to 
    provide relevant auto-completions based on previous user searches. For example...
    
<img src="https://raw.githubusercontent.com/bradmonk/egograph/master/webs/googlevs.png" width="600" border="4">
    
    You can retrieve the top 10 results in xml format by constructing a particular URL string. A
    function included in this tutorial will automatically build the appropriate URL string, query
    google, return the results, and parse out the 10 key terms that follow 'vs'. The tutorial then
    shows how to get 2nd-order results (10 x 10 = 1000 terms), and then generate a digraph using
    this data.



See Also
-----------------------------------------------------
- web('https://medium.com/applied-data-science/the-google-vs-trick-618c8fd5359f')
- web('http://bradleymonk.com/wp')


Attribution
-----------------------------------------------------
- Created by: Bradley Monk
- email: brad.monk@gmail.com
- website: http://bradleymonk.com
- 2020.06.30
