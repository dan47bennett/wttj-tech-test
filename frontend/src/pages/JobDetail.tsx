import { useParams, Link } from "react-router-dom";
import { Text } from "welcome-ui/Text";
import { Tag } from "welcome-ui/Tag";
import { Card } from "welcome-ui/Card";
import { Button } from "welcome-ui/Button";
import { Link as WUILink } from "welcome-ui/Link";
import { useState, useEffect } from "react";

interface Job {
  id: number;
  title: string;
  description: string;
  contract_type: string;
  office: string;
  status: string;
  work_mode: string;
}

export const JobDetail = () => {
  const { id } = useParams<{ id: string }>();
  const [job, setJob] = useState<Job | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch(`/api/jobs/${id}`)
      .then((res) => res.json())
      .then((response: { data: Job }) => {
        setJob(response.data);
        setLoading(false);
      })
      .catch((err) => {
        setError(err.message);
        setLoading(false);
      });
  }, [id]);

  if (loading) return <Text>Loading...</Text>;
  if (error) return <Text className="text-red-70">Error: {error}</Text>;
  if (!job) return <Text>Job not found</Text>;

  return (
    <div className="p-xl max-w-1200 my-0 mx-auto">
      <WUILink
        as={Link}
        to="/"
        variant="secondary"
        className="mb-md inline-block"
      >
        ← Back to jobs
      </WUILink>

      <div className="flex items-start justify-between gap-md mb-lg">
        <div>
          <Text variant="heading-xl">{job.title}</Text>
          <div className="flex flex-wrap gap-xs mt-sm">
            <Tag size="md" variant={"blue"}>
              {job.contract_type}
            </Tag>
            <Tag size="md" variant={"green"}>
              {job.status}
            </Tag>
            <Tag size="md" variant={"teal"}>
              {job.work_mode}
            </Tag>
          </div>
        </div>
        <Button as={Link} to={`/jobs/${job.id}/apply`}>
          Apply now
        </Button>
      </div>

      <div className="flex flex-col gap-md">
        <Card>
          <Card.Body>
            <Text variant="heading-sm" className="mb-sm">
              Description
            </Text>
            <Text variant="body-md">{job.description}</Text>
          </Card.Body>
        </Card>

        <Card>
          <Card.Body>
            <Text variant="heading-sm" className="mb-sm">
              Details
            </Text>
            <div className="grid grid-cols-2 gap-y-sm gap-x-lg">
              <div>
                <Text variant="label-sm" className="text-neutral-60">
                  Contract type
                </Text>
                <Text variant="body-md">{job.contract_type}</Text>
              </div>
              <div>
                <Text variant="label-sm" className="text-neutral-60">
                  Office
                </Text>
                <Text variant="body-md">{job.office}</Text>
              </div>
              <div>
                <Text variant="label-sm" className="text-neutral-60">
                  Work mode
                </Text>
                <Text variant="body-md">{job.work_mode}</Text>
              </div>
              <div>
                <Text variant="label-sm" className="text-neutral-60">
                  Status
                </Text>
                <Text variant="body-md">{job.status}</Text>
              </div>
            </div>
          </Card.Body>
        </Card>
      </div>
    </div>
  );
};
