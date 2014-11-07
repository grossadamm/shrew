module Analytics
  class AnalyticsConfiguration < Struct.new(:route_scope, :user_class)
    def initialize(params)
      super(* params.values_at(* self.class.members))
    end
  end
end
