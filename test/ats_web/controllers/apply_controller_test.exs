defmodule AtsWeb.Api.ApplyControllerTest do
  use AtsWeb.ConnCase
  import Ats.JobsFixtures

  @create_attrs %{
    full_name: "John Doe",
    email: "john.doe@gmail.com",
    last_known_job: "Dev Backend",
    phone: "+336 06 06 06 06",
    salary_expectation: "50000"
  }
  @invalid_attrs %{
    full_name: nil,
    email: nil,
    last_known_job: nil,
    phone: nil,
    salary_expectation: nil
  }

  describe "create applicant" do
    test "returns 201 and message when data is valid", %{conn: conn} do
      job = job_fixture()
      conn = post(conn, ~p"/api/jobs/#{job.id}/apply", apply: @create_attrs)

      assert %{"data" => %{"message" => "Application submitted successfully", "job_id" => id}} =
               json_response(conn, 201)

      assert id == job.id
    end

    test "returns 422 and errors when data is invalid", %{conn: conn} do
      job = job_fixture()
      conn = post(conn, ~p"/api/jobs/#{job.id}/apply", apply: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
