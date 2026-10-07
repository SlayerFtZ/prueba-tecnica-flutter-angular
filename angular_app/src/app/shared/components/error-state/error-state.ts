import { ChangeDetectionStrategy, Component, input, output } from '@angular/core';

@Component({
  selector: 'app-error-state',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="error" role="alert">
      <p>{{ message() }}</p>
      <button type="button" (click)="retry.emit()">Reintentar</button>
    </div>
  `,
  styles: `
    .error { padding: 2rem; text-align: center; color: #b91c1c; }
  `,
})
export class ErrorStateComponent {
  readonly message = input.required<string>();
  readonly retry = output<void>();
}
