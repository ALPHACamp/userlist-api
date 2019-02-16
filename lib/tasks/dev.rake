namespace :dev do

  task fetch_user: :environment do

    User.destroy_all

    url = "https://uinames.com/api/?ext"

    200.times do
      response = RestClient.get(url)
      data = JSON.parse(response.body)
      puts data
      user = User.create!(
        name: data["name"],
        surname: data["surname"],
        email: data["email"],
        birthday: data["birthday"]["mdy"],
        gender: data["gender"],
        age: data["age"],
        region: data["region"],
        avatar: data["photo"] 
      )

      puts "created user #{user.name}"
    end

    puts "now you have #{User.count} users data"
  end

end