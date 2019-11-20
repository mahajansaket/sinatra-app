require 'dm-core'
require 'dm-migrations'

# ===== Data model ===== 
class Comment
  include DataMapper::Resource  # mix-in
  property :id, Serial
  property :name, Text
  property :content, Text
  property :created_at, DateTime
end

DataMapper.finalize

# ===== Controller ===== 

# list
get '/comments' do
  @title = "Comments"
  if session[:logged] != true
    erb :login
  else
    @comments = Comment.all
    erb :comments
  end
end

# details
get '/comments/:id' do
  @title = "Comments"
  if session[:logged] != true
    erb :login
  else
    @comment = Comment.get(params[:id])

    if @comment != nil        # if exist, direct to not_found router
      erb :comment_detail
    else
      pass
    end
  end
end

# Create
get '/comments/new' do
  @title = "Comments"
  if session[:logged] != true
    erb :login
  else
    @comment = Comment.new
    erb :comment_new
  end
end

post '/comments' do
  if session[:logged] != true
    erb :login
  else
    comment = Comment.create(params[:comment])
    redirect to "/comments/#{comment.id}"
  end
end

# Edit
get '/comments/:id/edit' do
  @title = "Comments"
  if session[:logged] != true
    erb :login
  else
    @comment = Comment.get(params[:id])
    erb :comment_edit
  end
end

put '/comments/:id' do
  if session[:logged] != true
    erb :login
  else
    comment = Comment.get(params[:id])
    comment.update(params[:comment])
    redirect to "/comments/#{comment.id}"
  end
end

# delete
delete '/comments/:id' do
  if session[:logged] != true
    erb :login
  else
    Comment.get(params[:id]).destroy
    redirect to '/comments'
  end
end

# clear list
post '/comments/clear' do
  if session[:logged] != true
    erb :login
  else
    Comment.destroy
    redirect to '/comments'
  end
end

# restore default database
post '/comments/default' do
  if session[:logged] != true
    erb :login
  else

  Comment.destroy
  
  Comment.create(
    name: "letshaveagoodtm", 
    content: %{
  Pay attention, this series explores some very subtle story lines. I was extremely impressed when they introduced the bicameral mind concept when considering consciousness. That is one of the more important concepts when considering the origins of consciousness. I hope they explore this idea in greater detail and especially its implications related to physics. It is rare indeed to have a fictional work undertake such a complex topic without trivializing it. I definitely have to compliment the writers for undertaking such a complex topic and I hope they continue to explore the implications.

  Again, IMDb thinks I should add additional lines to my review which is ridiculous. I have offered a clear and concise review and they want an arbitrary number of lines, what kind of idiot makes this a requirement?
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "kythia", 
    content: %{
  SPOILER: I really liked the first season. It was a rather unique take on AI and the vices of mankind. Most of it was self-explanatory, like the constant debauchery and murder for fun, but the underlying search for hidden motives and "the truth" kept the show going, up to a grand finale.

  Season two, however, is a bit of a letdown. Most of the futuristic hightech stuff is gone, except for a few mercenary-type guys to replace all the wanton murder from season one. Since we now know about the two parallel plots from season one, the audience isn't fooled as easily anymore.

  So instead the writers set out to sidetrack us with irrelevant characters and plots who just end up dead or unresolved later on. The main story moves along at a much slower pace. Towards the end, the focus on AI development and AI trying to "free" itself seems lost almost completly.

  If I wouldn't know better, I'd think the producers of this show were so surprised by their own success that they had no real idea of how to continue, and are now just cobbling up random ideas.

  Season two is not bad, but its nowhere near as unique or visionary as the first. We'll have to see if the writers can turn it around for the inevitable season three.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "ndelic-19768", 
    content: %{
  Season 1 was absolutely amazing.

  Season 2 is absolute, complete and utter mess. The best description of season 2 plot is: "Reflective orange among church for wilderness airplane with spiritual expatriation of space submarine, unless".

  HBO should publicly apologize for the season 2 disaster and refund subscription to everyone who was tricked into watching season 2.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "atmobilemail", 
    content: %{
  The first season was novel and paced very well, along with the appropriate character developments. The second season was entirely something else. It was so bad it reminded me of Lost - which I stopped watching during the 3rd season. In Westworld, the pacing was gone. Useless flashbacks that had no importance to the story almost every five minutes ended any momentum it had. In fact, the flashbacks seemed as if somebody was just trying to ''stretch'' the show so that it would get a thrid season. As far as AI shows are concerned. I have a preference for Humans. After the second season, I couldn't see how they could have continued it with a third, but they did - and did they ever.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "timoverend83", 
    content: %{
  This show is so far perfect. The story is intriguing, the visuals are beautiful and the acting is incredible.

  The previous reviewer who said the violence is unnecessary has missed the point in my opinion. The violence is very much needed. It is there to make you feel uncomfortable, because it is that inner dark side and battle between good and evil (and more often than not the middle ground between) that is at the very epicenter of the human condition.This is what the show is often commenting on and this is what makes this show so interesting, thought provoking and ultimately entertaining.

  If it carries on in the same vein we will have a modern day classic on our hands.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "Randomizer2600", 
    content: %{
  I enjoyed Season 1 of Westworld, and was eager to see how the series developed. However, Season 2 is incomprehensible. There is no dramatic tension at all because if someone gets killed, they come back. Of course that's only the robots who can come back, but maybe the human was a robot. Or the character keeps showing up in endless flashbacks. There are some action sequences that could be interesting, but its difficult to care since the outcome seems irrelevant. Following any part of the plot is fruitless because what you are watching could be a ruse or a flashback. In parts, it seems like the writers are punishing for watching by making a scene as boring as possible. I'm not sure if I gave up trying follow what characters were trying to accomplish or I just no longer cared. Even Dolores, a fetching character with depth, is no longer of any interest.

  I do enjoy the musical score. And Season 2 is a good show to put on in the background if you have things to do around the house. Even when there is tense dialogue or what would be compelling action, I don't bother looking up as I unload the dishwasher because no dialogue, action or story development matters.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "vatigue", 
    content: %{
  I'm into episode 5 of season 2 now. Season 1 did a great job creating the universe and building up tension and suspense. It even made me get invested in some of the protagonists while failing to make me care for others. I stuck to it mainly due to the fact that I really loved Person of Interest and whatever Jonathan Nolan wrote before. Here's the problem: I don't care about any of the characters at this moment. I'm not invested in what they are working towards or if they even survive. The production value and acting are both top, there is nothing to complain there. But I keep getting distracted while watching an episode and start doing other things. The pace and cutting is weird since season 2 started and it fails to keep my attention at all. I was really waiting for the promised ancient Japan part of the park and all the samurais. Sadly, even that storyline fell flat and ended in clichéd characters and no caring on my end. I fail to find what drives most of the characters to do what they do. There are some goals I can see and others that just feel off. It feels like all of them are just wandering the park (that should be overrun by the parks security or government military by now) for no apparent reason. I'm sad because I really had high hopes for this due to Jonathan Nolan. Will give up watching now though. A solid 6 for the acting and production of the series. Nothing more cause I really don't care about any of the characters by now.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "georgechristophert", 
    content: %{
  Season 1 was profound, thought-provoking, gripping drama. I thought it the best TV show ever.

  Season 2 was self-indulgent, complexity for complexities sake, which ultimately led nowhere. Along the way were gapping holes that I can only guess are there out of laziness and/or to lure viewers to watch former episodes in a vain attempt to fill said holes, thus trapping them in the world of the show that now exists only for its own sake, that now offers nothing of value to the viewer in exchange for their time.

  Like the guests, the core drive of the show is to survive, at any cost. It will die without my viewing eyes to accompany it. 

  Another show that lost its way after an incredible first season.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "saumyagupta", 
    content: %{
  It has become just another show which relies completely on fancy graphics, wordy dialogues and frequent gunfights. Season 2 was all about fancy technology (which seems extremely impractical), people walking around in the desert having gunfights (throw in a couple swordfights here and there) and loose plot twists most of which seemed unnecessary. There's a false illusion of depth. The showmakers also don't seem to understand technology or anything related to artificial intelligence, nor have they even tried to do any basic research on it. The plot has gaping holes, and after a point you even stop caring whether the story is even coherent or not. I hated the second season as much as i loved the first. It has deterred me from watching any self-proclaimed sci-fi TV series or movie for at least the next couple months.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "Violent_Delight2804", 
    content: %{
  Wow, where to begin...

  First of all, the score by Ramin Djawadi is absolutely majestic!

  The actors, well, whatever I say just won't be enough. It's a total pleasure watching every second of their stellar performances.

  The plot - being a huge fan of sci-fi, it simply doesn't get better than that! 

  The scenery is gorgeous, it really takes you in the past. That constant mix of past and future is brilliant.

  Overall, I am amazed ( obviously ), mesmerized and absolutely loving every single thing about this show!

  Already a classic in my book <3
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "cagdas-21-315073", 
    content: %{
  From one of the best sci-fi television series I've ever seen in season 1, to a messy philosophical mumbo jumbo turd, that will not entertain anyone who's not a 14 year old boy.

  I like philosophical challenges, like some of Star Treks early years or TNG, but this is not challenging, interesting, provoking, or even a bit entertaining. I don't think they expected this one to make it to season two, and it shows.

  Frankly, it's crap. A well casted, brilliantly executed, amazingly looking piece of crap. I will not waste my time on the third season, and if you're reading this before watching season two, spare yourself. Walk away.
    }, 
    created_at: Time.now
  )
  Comment.create(
    name: "mynban", 
    content: %{
  First of all, it is very clear that the production mindset behind Westworld is far from creating a cheap product with generic high bursts of tension/love/horror/excitement. It is full of deep human conflicts, that is if you are open to watch it with a clear mind.

  Hopkins' quote from the end of episode 2 when he says "No" to "Odyssey on Red River" and explanation of his refusal feels like a statement of the production mindset. "Odyssey on Red River" pretty much summarizes everything wrong with entertainment media nowadays, and Westworld is a real delight that shines as a great production.

  I don't know how to tell its greatness without spoiling the show, but unless you want a cheap ride you will glimpse at screen in between your texting; you can not not enjoy this show!
    }, 
    created_at: Time.now
  )

    redirect to '/comments'
  end
end