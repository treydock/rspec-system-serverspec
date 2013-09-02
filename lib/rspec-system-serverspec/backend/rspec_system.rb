require 'serverspec/backend/exec'

module Serverspec
  module Backend
    class RSpecSystem < Serverspec::Backend::Exec
      def run_command(cmd, opt={})
        cmd = build_command(cmd)
        cmd = add_pre_command(cmd)
        ret = ssh_exec!(cmd)

        if @example
          @example.metadata[:command] = cmd
          @example.metadata[:stdout]  = ret[:stdout]
        end

        ret
      end

      private
      def ssh_exec!(command)
        node = @example ? @example.metadata[:node] : nil
        
        opts = {}
        opts[:c] = command
        opts[:n] = node unless node.nil?
        
        ::RSpecSystem::Helpers.shell(opts).to_hash.inject({}) do |h,(k,v)|
          k = :exit_status if k == :exit_code
        h[k] = v
        h
        end
      end
    end
  end
end
