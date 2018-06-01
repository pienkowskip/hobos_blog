{
    pl: {
        i18n: {
            plural: {
                keys: [:one, :few, :many, :other],
                rule: ->(n) {
                  n ||= 0
                  mod10 = n % 10
                  mod100 = n % 100

                  if n == 1
                    :one
                  elsif [2, 3, 4].include?(mod10) && ![12, 13, 14].include?(mod100)
                    :few
                  elsif ([0, 1] + (5..9).to_a).include?(mod10) || [12, 13, 14].include?(mod100)
                    :many
                  else
                    :other
                  end
                }
            }
        }
    }
}

# {:pl =>
#      { :i18n =>
#            { :plural =>
#                  { :keys => [:one, :few, :other],
#                    :rule => lambda { |n|
#                      if n == 1
#                        :one
#                      else
#                        if [2, 3, 4].include?(n % 10) &&
#                            ![12, 13, 14].include?(n % 100) &&
#                            ![22, 23, 24].include?(n % 100)
#
#                          :few
#                        else
#                          :other
#                        end
#                      end
#                    }
#                  }
#            }
#      }
# }