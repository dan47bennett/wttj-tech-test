defmodule Ats.CandidatesTest do
  use Ats.DataCase

  alias Ats.Candidates

  describe "candidates" do
    alias Ats.Candidates.Candidate

    import Ats.CandidatesFixtures

    @invalid_attrs %{email: nil, full_name: nil, last_known_job: nil, phone: nil}

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Candidates.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Candidates.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      valid_attrs = %{
        email: "some email",
        full_name: "some full_name",
        last_known_job: "some last_known_job",
        phone: "some phone"
      }

      assert {:ok, %Candidate{} = candidate} = Candidates.create_candidate(valid_attrs)
      assert candidate.email == "some email"
      assert candidate.full_name == "some full_name"
      assert candidate.last_known_job == "some last_known_job"
      assert candidate.phone == "some phone"
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Candidates.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()

      update_attrs = %{
        email: "some updated email",
        full_name: "some updated full_name",
        last_known_job: "some updated last_known_job",
        phone: "some updated phone"
      }

      assert {:ok, %Candidate{} = candidate} =
               Candidates.update_candidate(candidate, update_attrs)

      assert candidate.email == "some updated email"
      assert candidate.full_name == "some updated full_name"
      assert candidate.last_known_job == "some updated last_known_job"
      assert candidate.phone == "some updated phone"
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Candidates.update_candidate(candidate, @invalid_attrs)
      assert candidate == Candidates.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Candidates.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Candidates.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Candidates.change_candidate(candidate)
    end
  end
end
