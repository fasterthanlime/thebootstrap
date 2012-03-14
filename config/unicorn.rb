# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.
worker_processes 4

# Since Unicorn is never exposed to outside clients, it does not need to
# run on the standard HTTP port (80), there is no reason to start Unicorn
# as root unless it's from system init scripts.
# If running the master process as root and the workers as an unprivileged
# user, do this to switch euid/egid in the workers (also chowns logs):

# TODO: set the correct user and document it in README.md
#user "unprivileged_user", "unprivileged_group"

APP_PATH = File.expand_path('./')

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory APP_PATH # available in 0.94.0+

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen "/tmp/thebootstrap.sock", :backlog => 64
listen 8383, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# feel free to point this anywhere accessible on the filesystem
pid APP_PATH + "/tmp/pid/unicorn.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, some applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"

# Load the app into the master before forking workers
# for super-fast worker spawn times
preload_app true

# combine REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|
   # This allows a new master process to incrementally
   # phase out the old master process with SIGTTOU to avoid a
   # thundering herd (especially in the "preload_app false" case)
   # when doing a transparent upgrade.  The last worker spawned
   # will then kill off the old master process with a SIGQUIT.
   old_pid = "#{server.config[:pid]}.oldbin"
   if old_pid != server.pid
     begin
       sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
       Process.kill(sig, File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
     end
   end

  # Throttle the master from forking too quickly by sleeping.  Due
  # to the implementation of standard Unix signal handlers, this
  # helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy.
  # sleep 1
end

# Note: from a discussion about Unicorn/Rails/Ohm on #ohm on freenode
# "you don't need after_fork"
# "if you ever need to do some initialization or whatever, simply do it in after_fork"

#after_fork do |server, worker|
#  # if preload_app is true, then you may also want to check and restart any
#  # other shared sockets/descriptors such as Memcached, and Redis.
#
#end
