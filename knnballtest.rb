#KnnBallTest

require 'knnball'

data = [
    {:id => 1, :point => [6.3299934, 52.32444], :classifier => 2},
    {:id => 2, :point => [3.34444, 53.23259]},
    {:id => 3, :point => [4.22452, 53.243982]},
    {:id => 4, :point => [4.2333424, 51.239994]},
    # ...
]

index = KnnBall.build(data)

result = index.nearest([6.0, 52.0])
puts result # --> {:id=>2, :point=>[3.34444, 53.23259]}

#restults = index.nearest([3.43353, 52.34355], :limit => 3)
#puts result # --> [{...}, {...}, {...}]