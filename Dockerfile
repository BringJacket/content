FROM ruby:2.2.2-onbuild
EXPOSE 80
CMD ["bundle", "exec", "rackup", "-s puma", "-p 80"]