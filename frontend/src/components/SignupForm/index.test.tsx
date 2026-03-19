import { describe, it, expect, vi } from "vitest";
import { render, screen } from "@testing-library/react";
import { SignUpForm } from ".";

const onSubmit = vi.fn();

describe("SignUpForm", () => {
  it("renders email, password, confirm and submit button", () => {
    render(
      <SignUpForm
        onSubmit={onSubmit}
        serverError={null}
        initialLoading={false}
      />,
    );

    const form = screen.getByTestId("signup-form");

    expect(form).toBeVisible();
  });
});
