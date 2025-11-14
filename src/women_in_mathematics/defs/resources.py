"""
Dagster resources for the women in mathematics pipeline.
"""
import os
import dagster as dg
from dagster import ConfigurableResource
from openai import OpenAI


class OpenAIResource(ConfigurableResource):
    """Resource for OpenAI API client."""

    email: str
    api_key: str = ""

    def get_client(self) -> OpenAI:
        """Get an OpenAI client instance."""
        # Try to get API key from env if not provided
        key = self.api_key or os.getenv("OPENAI_API_KEY", "")
        return OpenAI(api_key=key)


@dg.definitions
def resources():
    return dg.Definitions(
        resources={
            "openai_resource": OpenAIResource(
                email="your-email@example.com",  # Update this
            ),
        }
    )
