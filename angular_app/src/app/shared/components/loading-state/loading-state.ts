import { ChangeDetectionStrategy, Component, input } from '@angular/core';

@Component({
  selector: 'app-loading-state',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `<p class="loading" aria-busy="true">{{ message() }}</p>`,
  styles: `.loading { padding: 2rem; text-align: center; color: #6b7280; }`,
})
export class LoadingStateComponent {
  readonly message = input('Cargando…');
}
