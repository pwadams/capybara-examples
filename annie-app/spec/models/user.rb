describe User do

  before do
    @user = User.new(first_name: "Bob", last_name: "Smith", email: "bob@smith.com", password: "password")
  end

  it 'is valid with a first name, last name, email, and password' do
    @user.valid?
    expect(@user).to be_valid
  end

  it 'is invalid without a first name' do
    @user.first_name = nil
    @user.valid?
    expect(@user.errors[:first_name]).to eq(["can't be blank"])
  end

  it 'is invalid without a last name' do
    @user.last_name = nil
    @user.valid?
    expect(@user.errors[:last_name]).to eq(["can't be blank"])
  end

  it 'is invalid without an email' do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to eq(["can't be blank"])
  end

  it 'is invalid without a password' do
    @user.password = nil
    @user.valid?
    expect(@user.errors[:password]).to eq(["can't be blank"])
  end

  it 'is invalid with a duplicate email address' do
    @user.save
    user_2 = User.new(first_name: "Roberta", last_name: "Smith", email: "bob@smith.com", password: "password")
    user_2.valid?
    expect(user_2.errors[:email]).to eq(["has already been taken"])
  end

end
