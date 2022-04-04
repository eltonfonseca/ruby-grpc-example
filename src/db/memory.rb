# frozen_string_literal: true

class Memory
  class << self
    def add(element)
      @resource = {}
      @resource[:id] = next_id
      @resource[:object] = element
      @database << @resource
      @resource[:id]
    end

    def get(id)
      database.filter { |resource| resource[:id] == id }.first
    end

    def remove(id)
      @database.delete_if { |resource| resource[:id] == id }
    end

    def all
      @database
    end

    private

    def database
      @database ||= []
    end

    def next_id
      resource_with_max_value = database.max_by { |resource| resource[:id] }
      return resource_with_max_value[:id] + 1 unless resource_with_max_value.nil?

      1
    end
  end
end
