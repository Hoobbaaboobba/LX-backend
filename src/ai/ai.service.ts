import { Injectable } from '@nestjs/common';
import OpenAI from 'openai';

@Injectable()
export class AiService {
  private readonly apiKey = process.env.OPENAI_API_KEY;

  private openai = new OpenAI({
    baseURL: 'https://api.groq.com/openai/v1',
    apiKey: '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',
  });

  async generateBranchName(title: string): Promise<string> {
    const prompt = `
Write me git brach name using this context: ${title}. Write only brach name.
`;
    try {
      const completion = await this.openai.chat.completions.create({
        model: 'llama-3.3-70b-versatile',
        messages: [{ role: 'user', content: prompt }],
      });

      return completion.choices[0].message.content;
    } catch (error) {
      return error;
    }
  }
}
