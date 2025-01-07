"""
Methods to return Liquibase changeset attributes
"""


def get_id(changeset):
    """
    Returns the changeset ID
    :param   changeset:    the changeset instance
    :return: string        the changeset ID
    """
    return changeset.getId()


def get_author(changeset):
    """
    Returns the changeset author
    :param   changeset:    the changeset instance
    :return: string        the changeset author
    """
    return changeset.getAuthor()


def get_file_path(changeset):
    """
    Returns the changeset file path
    :param   changeset:    the changeset instance
    :return: string        the changeset file path
    """
    return changeset.getFilePath()


def is_always_run(changeset):
    """
    Returns the changeset alwaysRun value
    :param   changeset:    the changeset instance
    :return: boolean       the changeset alwaysRun attribute value
    """
    return changeset.isAlwaysRun()


def is_run_on_change(changeset):
    """
    Returns the changeset runOnChange value
    :param   changeset:    the changeset instance
    :return: boolean       the changeset runOnChange attribute value
    """
    return changeset.isRunOnChange()


def get_contexts(changeset):
    """
    Returns the changeset contexts
    :param   changeset:    the changeset instance
    :return: string        the changeset contexts set
    """
    context_expression = changeset.getContexts()
    return context_expression.getContexts()


def get_labels(changeset):
    """
    Returns the changeset labels
    :param   changeset:    the changeset instance
    :return: string        the changeset labels set
    """
    labels = changeset.getLabels()
    return labels.getLabels()
