require 'dm-core'
require 'dm-migrations'

# ===== Data model ===== 
class Student
  include DataMapper::Resource  # mix-in
  property :id, Serial
  property :studentId, Integer
  property :firstname, String
  property :lastname, String
  property :birthday, Date
  property :address, String
end

# ===== Controller ===== 

# list
get '/students' do
  @title = "Students"
  if session[:logged] != true
    erb :login
  else
    @students = Student.all
    erb :students
  end
end

# details
get '/students/:id' do
  if session[:logged] != true
    erb :login
  else
    @title = "Students"
    @student = Student.get(params[:id])

    if @student != nil        # if exist, direct to not_found router
      erb :student_detail
    else
      pass
    end
  end
end

# Create
get '/students/new' do
  @title = "Students"
  if session[:logged] != true
    erb :login
  else
    @student = Student.new
    erb :student_new
  end
end

post '/students' do
  @title = "Students"
  if session[:logged] != true
    erb :login
  else
    student = Student.create(params[:student])
    redirect to "/students/#{student.id}"
  end
end

# Edit Student
get '/students/:id/edit' do
  @title = "Students"
  if session[:logged] != true
    erb :login
  else
    @student = Student.get(params[:id])
    erb :student_edit
  end
end

put '/students/:id' do
  @title = "Students"
  if session[:logged] != true
    erb :login
  else
    student = Student.get(params[:id])
    student.update(params[:student])
    redirect to "/students/#{student.id}"
  end
end

# delete student
delete '/students/:id' do
  @title = "Students"
  if session[:logged] != true
    erb :login
  else
    Student.get(params[:id]).destroy
    redirect to '/students'
  end
end

# clear students list
post '/students/clear' do
  if session[:logged] != true
    erb :login
  else
    Student.destroy
    redirect to '/students'
  end
end

# restore default database
post '/students/default' do
  if session[:logged] != true
    erb :login
  else

    Student.destroy

    Student.create(
      studentId: 1, 
      firstname: "Dolores", 
      lastname: "Abernathy", 
      birthday: Date.new(2016, 10, 2), 
      address: "Westworld"
    )

    Student.create(
      studentId: 2, 
      firstname: "Maeve", 
      lastname: "Millay", 
      birthday: Date.new(2016, 10, 2), 
      address: "Westworld"
    )

    Student.create(
      studentId: 3, 
      firstname: "Bernard", 
      lastname: "Lowe", 
      birthday: Date.new(2016, 10, 2), 
      address: "Westworld"
    )

    Student.create(
      studentId: 4, 
      firstname: "Teddy", 
      lastname: "Flood", 
      birthday: Date.new(2016, 10, 2), 
      address: "Westworld"
    )

    Student.create(
      studentId: 5, 
      firstname: "William", 
      lastname: "Grace", 
      birthday: Date.new(2016, 10, 2), 
      address: "Westworld"
    )

    Student.create(
      studentId: 6, 
      firstname: "Charlotte", 
      lastname: "Hale", 
      birthday: Date.new(2016, 10, 2), 
      address: "Westworld"
    )
    
    redirect to '/students'
  end
end