require 'active_record'

class CgtraderLevels::Privilege < ActiveRecord::Base
  enum kind: {
    extra_coins: 0,
    tax_reduction: 1,
    extra_3d_models: 2
  }
end
