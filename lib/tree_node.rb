module Tree

  module Node

    def self.included(target)
      target.send :include, InstanceMethods
    end

    module InstanceMethods

      attr_accessor :parent
      attr_writer :children

      def map(direction, collecting_object = [], &block)
        if direction == :down
          collecting_object << block.call(self)
          children.each { |child| child.map(direction, collecting_object, &block) }
        else
          parent.map(direction, collecting_object, &block) if parent
          collecting_object << block.call(self)
        end
        collecting_object
      end

      def root(&block)
        parent.root(&block) rescue block.call(self)
      end

      def children
        @children ||= []
      end

      def add_child object
        object.parent = self
        children << object
      end

    end

  end

end
