import { describe, it, expect, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import { ApplyForm } from ".";

const onSubmit = vi.fn();

describe("ApplyForm", () => {
  it("renders", () => {
    render(
      <ApplyForm
        onSubmit={onSubmit}
        serverError={null}
        initialLoading={false}
      />,
    );

    const form = screen.getByTestId("apply-form");

    expect(form).toBeVisible();
  });
});
