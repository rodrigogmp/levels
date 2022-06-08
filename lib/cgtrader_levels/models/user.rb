# require 'cgtrader_levels'
require 'active_record'

class CgtraderLevels::User < ActiveRecord::Base
  attr_reader :level

  after_initialize do
    self.reputation = 0

    set_level
  end

  after_update :set_level, if: -> { self.reputation_changed? }
  after_update :give_privileges_by_level_increase, if: -> { self.level_id_changed? }

  private

  def set_level
    matching_level = CgtraderLevels::Level.find_by(experience: reputation)

    return unless matching_level

    self.level_id = matching_level.id
    @level = matching_level
  end

  def give_privileges_by_level_increase
    CgtraderLevels::Privilege.where(level_id: @level.id).each do |privilege|
      self.coins += privilege.bonus if privilege.extra_coins?
      
      self.tax -= privilege.bonus if privilege.tax_reduction?

      self.available_3d_models_amount += privilege.bonus if privilege.extra_3d_models?
    end
  end
end
