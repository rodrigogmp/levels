require 'cgtrader_levels'

describe CgtraderLevels::User do
  before do
    CgtraderLevels::Level.destroy_all
    @level_1 = CgtraderLevels::Level.create!(experience: 0, title: 'First level')
    @level_2 = CgtraderLevels::Level.create!(experience: 10, title: 'Second level')
    @level_3 = CgtraderLevels::Level.create!(experience: 13, title: 'Third level')
  end

  describe 'new user' do
    it 'has 0 reputation points' do
      @user = CgtraderLevels::User.new

      expect(@user.reputation).to eq(0)
    end

    it "has assigned 'First level'" do
      @user = CgtraderLevels::User.new

      expect(@user.level.id).to eq(@level_1.id)
    end
  end

  describe 'level up' do
    it "level ups from 'First level' to 'Second level'" do
      user = CgtraderLevels::User.create!
      
      expect {
        user.update_attribute(:reputation, 10)
      }.to change { user.level.id }.from(@level_1.id).to(@level_2.id)
    end

    it "level ups from 'Second level' to 'Third level'" do
      @user = CgtraderLevels::User.create!

      @user.update_attribute(:reputation, 10)
      expect {

        @user.update_attribute(:reputation, 13)
        
      }.to change { @user.level.id }.from(@level_2.id).to(@level_3.id)
    end
  end

  describe 'level up bonuses & privileges' do
    it 'gives coins' do
      @extra_coins_privilege = CgtraderLevels::Privilege.create!(level_id: @level_2.id, kind: :extra_coins, bonus: 10)
      @user = CgtraderLevels::User.create!(coins: 1)

      previous_coins_amount = @user.coins

      expect {
        @user.update_attribute(:reputation, 10)
        
      }.to change { @user.coins }.from(previous_coins_amount).to(previous_coins_amount + @extra_coins_privilege.bonus)
    end

    it 'reduces tax rate' do
      @tax_reduction_privilege = CgtraderLevels::Privilege.create!(level_id: @level_2.id, kind: :tax_reduction, bonus: 20)
      @user = CgtraderLevels::User.create!

      previous_tax_value = @user.tax

      expect {
        
        @user.update_attribute(:reputation, 10)
        
        
      }.to change { @user.tax }.from(previous_tax_value).to(previous_tax_value - @tax_reduction_privilege.bonus)
    end

    it 'increase the available 3d models amount' do
      @extra_3d_models_privilege = CgtraderLevels::Privilege.create!(level_id: @level_2.id, kind: :extra_3d_models, bonus: 2)
      @user = CgtraderLevels::User.create!

      previous_available_3d_models_amount = @user.available_3d_models_amount

      expect {
        @user.update_attribute(:reputation, 10)
        
      }.to change { @user.available_3d_models_amount }.from(previous_available_3d_models_amount).to(previous_available_3d_models_amount + @extra_3d_models_privilege.bonus.to_i)

    end

    it 'gives plenty of privileges by reaching a specific level' do
      extra_3d_models_privilege = CgtraderLevels::Privilege.create!(level_id: @level_2.id, kind: :extra_3d_models, bonus: 2)
      tax_reduction_privilege = CgtraderLevels::Privilege.create!(level_id: @level_2.id, kind: :tax_reduction, bonus: 20)
      extra_coins_privilege = CgtraderLevels::Privilege.create!(level_id: @level_2.id, kind: :extra_coins, bonus: 10)

      user = CgtraderLevels::User.create!

      expect {
        user.update_attribute(:reputation, 10)
      }.to change { user.available_3d_models_amount }.and change { user.coins }.and change { user.tax }
    end
  end
end
