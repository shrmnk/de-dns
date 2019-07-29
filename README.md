# de-dns

de-dyndns your hosts and use your existing Cloudflare domain.

Still a work-in-progress. This was started as a personal project to shifting out of dyndns subscriptions which charges more than a single .com domain for dynamically updating hosts.

# Developing

### Requirements

- Ruby 2.5.5
- Postgres >= 9
- NodeJS >= 10 (or any ExecJS-compatible)

### Local development environment

Copy .env.sample and modify the contents to suit your local environment.

1. Install gems: `bundle install`
2. Install JS packages: `yarn --cwd client install`
3. Run backend on port 3001: `PORT=3001 rails s`
4. Run frontend: `yarn --cwd client start`

# Notes

This project is rough around the edges and could definitely do with some polish. It started as an experiment to using Cloudflare as the backend to a dynamically-updating DNS service, and using vanilla Create React App + Rails API Only, but with OAuth scoped permissions and the wide availability of alternatives such as http://www.duckdns.org/ , this project started to become less and less important to my work.

Feel free to raise pull requests.
