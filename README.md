# Technical Test for Fullstack Developer - Application Tracking System

Welcome to the Fullstack Developer Job Application Tracking System! This REST API backend, built with Elixir Phoenix, is designed to assist in conducting technical tests for fullstack developer candidates.

This application is a simplified job board.
An unregistered user is able to list all jobs and can apply to a job.
It provides a platform to manage job offers and track candidate information.

A registered user can create, edit, and delete job offers.
On each job offer, a registered user can see the list of candidates who have applied to the job.

## Repository Structure

This is a monorepo containing both backend and frontend:

- **Backend (root):** Phoenix/Elixir REST API
- **Frontend (`/frontend`):** React 19 application with TypeScript

## Installation

1. Clone the repository
2. Navigate to the project directory: `cd technical-test-fullstack-main`
3. Install language versions and dependencies:

   We suggest you use asdf (or another version manager) to manage Erlang, Elixir and Node versions.

   To install asdf, visit <http://asdf-vm.com/guide/getting-started.html>.

   Add the required plugins:

   ```bash
   asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
   asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
   asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
   ```

   Then install the versions specified in the `.tool-versions` file:

   ```bash
   asdf install
   ```

   You can now install the Elixir dependencies:

   ```bash
   mix deps.get
   ```

4. Set up the database and update the configuration in `config/dev.exs` or start a Docker container with the `docker-compose.yml` file included in the project.
5. Create and migrate the database: `mix ecto.setup`
6. Run the tests: `mix test`
7. Start the Phoenix server: `mix phx.server`
8. Frontend Setup:

   ```bash
   cd frontend
   corepack enable
   yarn install
   yarn dev  # Starts on http://localhost:5173
   ```

## Exercise

We are glad to introduce you to this technical test which will help us better understand your skills and competencies related to our tech stack. In this exercise, we will use our in-house built Applicant Tracking System (ATS) application developed with Phoenix Elixir and React.

The goal of this test is to simulate a real-world scenario where you will need to add a new feature to an existing application.
Your work will be evaluated based on your approach, your understanding of the problem and the quality of your code.

You need to implement a **Job search function** !

That new feature must allow all users to search for jobs. This should allow users to search using various parameters like job title, location, work mode, etc. You can extend this requirement to anything that makes sense for this project. You will have to implement the backend functionality.

## Evaluation Criteria

**Backend**

- Code quality and organization
- Proper use of Phoenix/Elixir patterns and conventions
- Database design and query optimization
- Error handling and edge cases
- Test coverage

**Frontend**

- React best practices and component architecture
- Proper use of hooks and state management
- Code organization and reusability
- UI/UX quality with welcome-ui
- Testing quality and coverage
- TypeScript usage and type safety

**Overall**

- Git commit history and messages
- Code documentation and comments
- Problem-solving approach
- Attention to requirements

## Notes

- Take your time and demonstrate your abilities
- Focus on code quality over quantity
- Don't hesitate to update the readme to explain your decisions and what you would have done if given more time
- Be transparent on LLM usage!
- If you run out of time, prioritize completing the required task over improving it
- You can add additional libraries if needed, but justify your choices

Happy coding and good luck!
