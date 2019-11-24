#seedingをするときはbundle exec rake db:seed
#https://qiita.com/kumasuke/items/545afaf5876d3dc52670

require "csv"

CSV.foreach('db/annotation.csv', headers: true) do |row|
  Annotation.create([
    {
    path: row['path'],
    category_id: row['category_id'],
    information: row['information'],
    }
    ]
  )
end

Category.create(
  [
    {
      name: 'Bird',
    },
    {
      name: 'Non-bird',
    },
    {
      name: 'UnKnown',
    }
  ]
)



