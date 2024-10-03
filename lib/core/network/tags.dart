abstract class InterceptorTag {
  const InterceptorTag();

  T? find<T extends InterceptorTag>() {
    if (this is T) {
      return this as T;
    }
    if (this is MultiTags) {
      return (this as MultiTags).tags.whereType<T>().firstOrNull;
    }
    return null;
  }
}

final class NoAuthorizationTag extends InterceptorTag {
  const NoAuthorizationTag();
}

const noAuthorization = NoAuthorizationTag();

final class BaseUrlTag extends InterceptorTag {
  const BaseUrlTag(this.baseUri);

  final Uri baseUri;
}

final class InjectTokenTag extends InterceptorTag {
  const InjectTokenTag(this.token);

  final String token;
}

final class MultiTags extends InterceptorTag {
  const MultiTags(this.tags);

  final List<InterceptorTag> tags;
}
