import { ChangeDetectionStrategy, Component, input } from '@angular/core';

@Component({
  selector: 'app-stat-card',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="stat">
      <span class="label">{{ label() }}</span>
      <strong class="value">{{ value() }}</strong>
    </div>
  `,
  styles: `
    .stat { background: #fff; border-radius: 8px; padding: 1.25rem; box-shadow: 0 1px 3px #0001; }
    .label { display: block; color: #6b7280; font-size: 0.85rem; }
    .value { font-size: 1.75rem; }
  `,
})
export class StatCardComponent {
  readonly label = input.required<string>();
  readonly value = input.required<string | number>();
}
