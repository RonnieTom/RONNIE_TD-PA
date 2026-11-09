/// <reference types="vite/client" />

interface Window {
  GetParentResourceName?: () => string
}

declare function GetParentResourceName(): string

/** WebCodecs — Chromium / CEF */
declare class AudioEncoder {
  constructor(init: {
    output: (chunk: EncodedAudioChunk, meta?: unknown) => void
    error: (e: Error) => void
  })
  configure(config: {
    codec: string
    sampleRate: number
    numberOfChannels: number
    bitrate?: number
  }): void
  encode(data: AudioData): void
  flush(): Promise<void>
  close(): void
  readonly state: 'unconfigured' | 'configured' | 'closed'
}

declare class AudioDecoder {
  constructor(init: {
    output: (data: AudioData) => void
    error: (e: Error) => void
  })
  configure(config: { codec: string; sampleRate: number; numberOfChannels: number }): void
  decode(chunk: EncodedAudioChunk): void
  close(): void
}

declare class EncodedAudioChunk {
  constructor(init: {
    type: 'key' | 'delta'
    timestamp: number
    data: BufferSource
  })
  readonly byteLength: number
  copyTo(destination: AllowSharedBufferSource): void
}

declare class AudioData {
  constructor(init: {
    format: string
    sampleRate: number
    numberOfFrames: number
    numberOfChannels: number
    timestamp: number
    data: BufferSource
  })
  readonly numberOfFrames: number
  readonly sampleRate: number
  copyTo(
    destination: AllowSharedBufferSource,
    options?: { planeIndex?: number; format?: string },
  ): void
  close(): void
}
